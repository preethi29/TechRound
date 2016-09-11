require 'will_paginate/array'

class CollegesController < ApplicationController

    def index
        colleges = JSON.parse(File.read('public/colleges.json'))
        @paginated_colleges =colleges.paginate(page: params[:page], per_page: 10)
    end
end