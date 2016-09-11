require 'spec_helper'

describe CollegesScraper do
    before(:each) do
        @college1 = {
            'institution': {
                'displayName': 'Harvard University',
                'city': 'Cambridge',
                'state': 'MA'
            },
            'ranking': {
                'displayRank': '#1'
            },
            'searchData': {
                'tuition': {
                    'displayValue': ['$43,450']
                },
                'enrollment': {
                    'displayValue': '5,391'
                },
                'acceptance-rate': {
                    'displayValue': '87%'
                }
            }
        }
        @college2 = {
            'institution': {
                'displayName': 'Yale University',
                'city': 'New Haven',
                'state': 'CT'
            },
            'ranking': {
                'displayRank': '#2'
            },
            'searchData': {
                'tuition': {
                    'displayValue': ['$43,400']
                },
                'enrollment': {
                    'displayValue': '5,191'
                },
                'acceptance-rate': {
                    'displayValue': '89%'
                }
            }
        }
        @first_page ={
            data: {
                next_link: "http://colleges.usnews.rankingsandreviews.com/best-colleges/api/schools?school-type=national-universities&_page=2",
                items: [@college1]
            }
        }
        @second_page ={
            data: {
                next_link: nil,
                items: [@college2]
            }
        }
    end


    it 'should scrap_colleges_data' do
        stub_request(:get, 'http://colleges.usnews.rankingsandreviews.com/best-colleges/api/schools?school-type=national-universities&format=json')
            .to_return(body: @first_page.to_json)
        stub_request(:get, 'http://colleges.usnews.rankingsandreviews.com/best-colleges/api/schools?school-type=national-universities&_page=2')
            .to_return(body: @second_page.to_json)
        expect(CollegesScraper.scrap_colleges_data).to eq([@college1.deep_stringify_keys, @college2.deep_stringify_keys])
    end


    it 'should map scraped data' do
        mapped_data = CollegesScraper.map_scraped_data([@college1.deep_stringify_keys, @college2.deep_stringify_keys])
        expect(mapped_data).to eq([{:name => 'Harvard University', :rank => '#1', :tuition_fees => '$43,450',
                                    :total_enrollment => '5,391',:acceptance_rate=> '87%',:address=>"Cambridge, MA"},
                                   {:name => 'Yale University', :rank => '#2', :tuition_fees => '$43,400',
                                    :total_enrollment => '5,191',:acceptance_rate=> '89%', :address=>"New Haven, CT"},
                                  ])

    end

    it "should create 'colleges.json' and put colleges data in it" do
        file = double('file')
        expect(File).to receive(:open).with('public/colleges.json', 'w').and_yield(file)
        expect(file).to receive(:write).with([@college1, @college2].to_json)

        CollegesScraper.write_to_file([@college1.deep_stringify_keys, @college2.deep_stringify_keys])
    end
end