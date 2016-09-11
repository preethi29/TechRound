desc "gets top US colleges and stores it in a json file"
task top_colleges: :environment do
    CollegesScraper.get_colleges
end
