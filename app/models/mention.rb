class Mention

    attr_reader :mentionable
    include Rails.application.routes.url_helpers


    def self.create_from_text(post)
        puts post
        @current_mode = post.user.current_mode               #this need to be solved
        puts "in text"
        potential_matches = post.content.scan(/@\w+/i)
        puts potential_matches
        potential_matches.uniq.map do |match|
            mention = Mention.create_from_match(match,post.user_id)
            puts mention
            next unless mention
            post.update_attributes!(content: mention.markdown_string(post.content))
            # You could fire an email to the user here with ActionMailer
            mention
        end.compact
    end

    def self.create_from_match(match,self_id)
        user = User.find_by(username: match.delete('@'))
        puts "hi"
        puts @current_mode

        is_follower = FollowMapping.where(:followee_id => self_id, :follower_id => user.id,:mode => @current_mode).length > 0     #this need to be accessed form user class

        UserMention.new(user) if user.present? and is_follower
    end



    def initialize(mentionable)
        @mentionable = mentionable
    end

    class UserMention < Mention
        def markdown_string(text)
            # Don't forget to add your app's host here for production code!
            host = Rails.env.development? ? 'http://localhost:3000' : 'sociograms.in'
            puts mentionable
            link_to_user_profile = host + "/" + mentionable.username + "/"      #hard_coded
            text.gsub(/@#{mentionable.username}/i,
                      "[**@#{mentionable.username}**](#{link_to_user_profile})")
        end
    end
end