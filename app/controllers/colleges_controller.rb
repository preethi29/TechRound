require 'will_paginate/array'

class CollegesController < ApplicationController

    def index
        begin
            colleges_list_string = File.read('public/colleges.json')
        rescue => err
            colleges_list_string ='[]'
        end
        colleges = JSON.parse(colleges_list_string)
        @paginated_colleges =colleges.paginate(page: params[:page], per_page: 10)
    end
end