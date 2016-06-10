namespace :dev do

  task :dev_db_rebuild => ['db:drop:all', 'db:create', 'db:migrate', 'dev:fetch_dev_impression', 'dev:add_admin_user']

  desc "add admin user"
  task :add_admin_user => :environment do
    AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
  end


  task :fetch_legislators_from_g0v => :environment do
    puts "fetch_legislators_from_g0v"

    url = "http://vote.ly.g0v.tw/api/legislator/"
    (1..1900).each do |i|
      p "fetch #{i}"
      begin
        raw_content = RestClient.get(url + i.to_s)
        data = JSON.parse( raw_content )
        impression = Impression.find_or_initialize_by(name: data["name"])
        if impression.new_record?
          gender = data["each_terms"].first["gender"]
          gender == "女" ? impression.gender = "female" : impression.gender = "male"
          impression.g0v_legislator_api = data["url"]
        end
        jobs = impression.politician_jobs
        data["each_terms"].each do |term|
          job = jobs.find_or_initialize_by(th: term["ad"], title: term["title"],
                                   electoral_region: term["county"], organization: "立法院")
          join_job = impression.impression_politician_jobs.find_or_initialize_by(impression: impression, politician_job: job)
          join_job.started_on = term["term_start"]
          join_job.ended_on = term["term_end"]["date"]

          th_max = jobs.pluck(:th).max
          if th_max.nil? or term["ad"].to_i >= th_max
            impression.party_list = term["elected_party"]
            impression.image = term["image"]
            impression.description = "學歷\n" << term["education"].to_s << "\n" << "經歷\n" << term["experience"].to_s
          end
          impression.save
        end
      rescue => e
        p "#{i} error, #{e.response}"
      end
    end
    p "end"
  end

  task :fetch_dev_impression => :environment do
    puts "fetch_legislators_from_g0v"

    url = "http://vote.ly.g0v.tw/api/legislator/"
    (1370..1400).each do |i|
      p "fetch #{i}"
      begin
        raw_content = RestClient.get(url + i.to_s)
        data = JSON.parse( raw_content )
        impression = Impression.find_or_initialize_by(name: data["name"])
        if impression.new_record?
          gender = data["each_terms"].first["gender"]
          gender == "女" ? impression.gender = "female" : impression.gender = "male"
          impression.g0v_legislator_api = data["url"]
        end
        jobs = impression.politician_jobs
        data["each_terms"].each do |term|
          job = jobs.find_or_initialize_by(th: term["ad"], title: term["title"],
                                   electoral_region: term["county"], organization: "立法院")
          join_job = impression.impression_politician_jobs.find_or_initialize_by(impression: impression, politician_job: job)
          join_job.started_on = term["term_start"]
          join_job.ended_on = term["term_end"]["date"]

          th_max = jobs.pluck(:th).max
          if th_max.nil? or term["ad"].to_i >= th_max
            impression.party_list = term["elected_party"]
            impression.image = term["image"]
            impression.description = "學歷\n" << term["education"].to_s << "\n" << "經歷\n" << term["experience"].to_s
          end
          impression.save
        end
      rescue => e
        p "#{i} error, #{e.response}"
      end
    end
    p "end"
  end


end
