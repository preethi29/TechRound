require 'net/http'
require 'json'

class CollegesScraper
    def self.get_colleges
        colleges = scrap_colleges_data
        colleges = map_scraped_data(colleges)
        write_to_file(colleges)
    end

    def self.write_to_file(colleges)
        File.open('public/colleges.json', 'w') do |f|
            f.write(colleges.to_json)
        end
        puts 'Colleges info can be found in public/colleges.json'
    end

    def self.scrap_colleges_data
        colleges = []
        url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/api/schools?school-type=national-universities&format=json'
        until url.nil?
            puts 'Fetching college data......'
            res = JSON.parse(Net::HTTP.get(URI(url)))
            data = res['data']
            colleges.concat(data['items'])
            url = data['next_link']
        end
        colleges
    end

    def self.map_scraped_data(colleges)
        colleges.map! { |college|
            search_data = college['searchData']
             mapped_college = {
                'name': college['institution']['displayName'],
                'rank': college['ranking']['displayRank'],
                'tuition_fees': search_data['tuition']['displayValue'][0],
                'total_enrollment': search_data['enrollment']['displayValue'],
                'acceptance_rate': search_data['acceptance-rate']['displayValue'],
                'address': college['institution']['city']+ ', '+ college['institution']['state']
            }
            mapped_college
        }
    end
end