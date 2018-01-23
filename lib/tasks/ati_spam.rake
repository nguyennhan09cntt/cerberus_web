require 'rest-client'

namespace :batch do
  desc "Run Task"
  #  cd /usr/local/src/project/cerberus_web/ && /usr/local/rvm/wrappers/ruby-2.4.2/rake RAILS_ENV=development batch:ati_spam
  task :ati_spam => :environment do  |t, args|
    puts "Begin Task"
    group_id = '545206412228291'
    site = Site.where('facebook_id = :group_id', {group_id: group_id}).first
    access_token = 'EAAL3tYEPxDcBAD4k60d5PA9xwCblTZBPQRf0BrDKfpfZBsEDA6OE68nBhXnk3RdrC4SIRRRv7cw108ZCnYVBJ4mk8NIN6Jcmv3cVArFzFG8ZCsteo8QqvZBAHD0HoGero3CSnYfNJWDWAfpGI3f7rZCzdjQHYjMsoZD'
    if valid_user_token(access_token)
      p "valid_user_token"
      koala_page = Koala::Facebook::API.new(access_token)

      posts = koala_page.get_connections(
        group_id,
        'feed', {
          limit: 100,
          fields: ['message', 'created_time', 'from', 'attachments']
        }
      )

      url = 'http://127.0.0.1:5050/api/'
      url = 'http://ln3.in'
      response = RestClient.get(url, headers={})
      p response

      # posts.each do |fpost|
      #   begin
      #     post = {}
      #     post[:uid] = Post.random_uid(site[:uid])
      #     post[:facebook_id] = fpost['id']
      #     post[:site_id] = site[:id]
      #     post[:status] = 2
      #     post[:created_at] = DateTime.parse(fpost['created_time']) + 7.hours

      #     post[:spam] = 1 if  post['message'].blank?

      #     times = [100.0, 200.0, 300.0, 150.0, 80.0, 110.0]
      #     time = times.sample
      #     sleep(time)
      #   rescue => ex
      #     msg = ex.message +' APP TOKEN: '+ FACEBOOK_CONFIG['token']
      #     p msg
      #     sleep(100.0)
      #   ensure
      #     next
      #   end

      # end
    end


    puts "End Task"
  end

  def valid_user_token(token)
    # graph = Koala::Facebook::API.new FACEBOOK_CONFIG['token'], FACEBOOK_CONFIG['secret']
    # data = graph.debug_token token
    # data["data"]["is_valid"]
    true
  end

end
