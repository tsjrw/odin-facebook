module ApplicationHelper
    def home?
        params[:home] == "true" ? true : false
    end

    def redirection( post)
        if home? 
            redirect_to root_path 
        else
            redirect_to user_path(post.author)
        end
    end
end
