# spec/requests/user_authentication_spec.rb

RSpec.describe "User Authentication", type: :request do
  context "user registration" do
    it "signs up successfully" do
      post user_registration_path, params: { user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end

    it "fails to sign up with invalid data" do
      post user_registration_path, params: { user: { email: 'invalid_email', password: 'password', password_confirmation: 'password' } }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  context "password reset" do
    it "resets password successfully" do
      user = create(:user)

      post user_session_path, params: { user: { email: user.email, password: user.password } }

      get new_user_password_path
      post user_password_path, params: { user: { email: user.email } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end

  context "user authentication" do
    it "logs in successfully" do
      user = create(:user)

      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end

    it "fails to log in with incorrect credentials" do
      user = create(:user)

      post user_session_path, params: { user: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "logs out successfully" do
      user = create(:user)

      post user_session_path, params: { user: { email: user.email, password: user.password } }

      delete destroy_user_session_path

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end
end
