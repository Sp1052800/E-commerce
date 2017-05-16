module ProductsHelper
	def user_signed_in?
		unless session[:user_id].blank?
			true 
		else
			false
		end
	end
end
