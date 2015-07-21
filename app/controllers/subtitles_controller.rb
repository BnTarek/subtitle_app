require 'nokogiri'

class SubtitlesController < ApplicationController
	def new
		@subtitle = params[:subtitle]
	end

	def create
		if params[:subtitle][:content].empty?
      flash.now[:danger] = "Subtile can't be empty!"
			render 'new'
		else
			content = params[:subtitle][:content]
			doc = Nokogiri::HTML(content)
			
			time = Array.new			
			@text = Array.new
			@fTime = Array.new

			doc.css('em').each do |node|
				time << node.text
			end
			
			doc.css('p').each do |node|
				@text << node.text
			end

			(0..(time.length-1)).step(1) do |n|
				if time.length-1 == n
					@fTime[n] = "00:0#{time[n]},000 --> 01:0#{time[n]},000"
				else
					@fTime[n] = "00:0#{time[n]},000 --> 00:0#{time[n+1]},000"
				end
			end

			flash.now[:success] = "Done!"
			render 'new'
		end
	end
end
