module ControllerHelpers
  module Session
    def set_current_user
        allow(controller).to receive(:current_user).and_return(user)
    end
    def set_current_account
        allow(controller).to receive(:current_account).and_return(account)
    end
    def sign_in
        set_current_user
        set_current_account
    end
  end
end
