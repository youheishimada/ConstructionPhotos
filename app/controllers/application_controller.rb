class ApplicationController < ActionController::Base

    # ログアウト後の遷移先をトップページに設定
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
