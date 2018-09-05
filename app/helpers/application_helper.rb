module ApplicationHelper
    def sortcolumn(column)
        css_class = column == params[:sort] ? "hilite" : nil;
        logger.debug "Css class to be passed: #{css_class}"
        css_class
    end
end
