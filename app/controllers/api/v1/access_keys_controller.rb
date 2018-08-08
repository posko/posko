class Api::V1::AccessKeysController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @access_keys = AccessKeysQuery.new(params, current_user.access_keys).call

    # use serializer or jbuilder later
    render json: { access_keys: @access_keys }
  end
end
