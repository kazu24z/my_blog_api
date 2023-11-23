# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
      current_user: auth_required(query) ? current_user : nil
    }
    result = AppSchema.execute(query, variables:, context:, operation_name:)
    render json: result
  rescue InvalidTokenError => e
    render json: { error: e.message }, status: :unauthorized
    nil
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
    nil
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  # 認証が必要な処理かを判定する
  def auth_required(query)
    # field名を配列で取得
    field_names = get_field_names(query)

    # 取得したfield名が要認証リストに含まれていることをチェック
    result = field_names.any? do |field_name|
      ## 複数のfield_nameが渡ってきた場合、１件でも必要だった場合、その時点でtrueを返す
      auth_required_list.include?(field_name)
    end
    return true if result

    false
  end

  def auth_required_list
    %w[
      logout
      createPost
      deletePost
      editPost
      getPost
      getPosts
    ]
  end

  def get_field_names(query)
    # queryからfield_nameを取得する
    parsed_query = GraphQL.parse(query)
    operations = parsed_query.definitions.each do |definition|
      next unless definition.is_a?(GraphQL::Language::Nodes::OperationDefinition)

      field_names = []
      # SelectionSetを取得
      definition.selections.each do |selection|
        # Fieldノードをチェック
        next unless selection.is_a?(GraphQL::Language::Nodes::Field)

        # Fieldの名前を取得
        field_names << selection.name
      end

      return field_names
    end
  end

  def current_user
    token = request.headers['Authorization'].split(" ")[1]

    raise InvalidTokenError, 'Token not present' unless token.present?

    begin
      # トークンをデコード
      decoded_token = JwtToken.decode(token)
      # 値からユーザーを取得できない場合、return

      # expが切れているかチェック
      raise InvalidTokenError, 'Token expired' if decoded_token[:exp].nil? || decoded_token[:exp] < Time.now.to_i

      # userが存在するかチェック
      @current_user = User.find(decoded_token[:user_id])

      # jtiが有効かチェック
      raise InvalidTokenError, 'Invalid token' unless decoded_token[:jti] == @current_user.jti
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      raise InvalidTokenError, 'Invalid token'
    end

    @current_user
  end
end
