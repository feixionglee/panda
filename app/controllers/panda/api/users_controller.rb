module Panda
  module Api
  class UsersController < BaseController

    # TODO: Fixme
    def upload_avatar
      current_user.update({avatar: params[:user][:avatar]})
      current_user.reload
      my_info
    end

    def my_info
      render json: current_user
    end

    # 上传个人照片
    def append_photo
      u = current_user
      u.append_images params[:user][:photos] if params[:user][:photos]

      render json: current_user, include: [:photos]
    end

    # put 删除个人顶部滚动照片
    def delete_photos
      u = current_user
      u.remove_photos!
      u.save

      render json: u, include: [:photos]
    end

    def delete_photo
      u = current_user
      u.delete_photo(params[:file_name])
      u.save

      render json: u, include: [ :photos]
    end
  end
  end
end
