class MainController < ApplicationController
  def home
  	@interviews = Interview.all.group_by { |x| x.date.to_date}
  	@interviews = Hash[ @interviews.sort_by{|k, _| k}.reverse ] 
  end
end
