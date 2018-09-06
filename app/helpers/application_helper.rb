module ApplicationHelper
    def sortcolumn(column)
        css_class = column == params[:sort] ? "hilite" : nil;
        #logger.debug "Css class to be passed: #{css_class}"
        css_class
    end
    
    def checkboxChecked(rating)
        unless session[:ratings].to_s.strip.empty? 
          return true 
        end
         session[:ratings].include?("#{rating}")
    end
end
