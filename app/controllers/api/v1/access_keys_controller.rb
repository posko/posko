class Api::V1::AccessKeysController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @access_keys = current_user.access_keys

    # use serializer or jbuilder later
    render json: { access_keys: @access_keys }
  end
end
