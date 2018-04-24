class Mention

    attr_reader :mentionable
    include Rails.application.routes.url_helpers


    def self.create_from_text(object)               #object can be post ,comment or reply
        if check_annonymous_post(object)
            puts object
            current_user = object.user
            @current_mode = current_user.current_mode               #this need to be solved
            puts "in text"
            potential_matches = object.content.scan(/@\w+/i)
            puts potential_matches
            potential_matches.uniq.map do |match|
                mention = Mention.create_from_match(match,object.user_id)
                unless mention.nil?
                    recipient_user =  mention.mentionable                   #jisko mention kia h
                end
                next unless mention
                object.update_attributes!(content: mention.markdown_string(object.content))
                # You could fire an email to the user here with ActionMailer
                Mention.send_notification(object, recipient_user, current_user)         #sending notification to mentioned user
                mention
            end.compact
        end
    end

    def self.create_from_match(match,current_user_id)
        user = User.find_by(username: match.delete('@'))
        puts "hi"
        puts @current_mode

        unless user.nil?
            is_follower = FollowMapping.where(:followee_id => current_user_id, :follower_id => user.id,:mode => @current_mode).length > 0     #this need to be accessed form user class
            UserMention.new(user) if user.present? and is_follower
        end
    end

    def self.send_notification(object, recipient_user, current_user)
        object_name =  object.class.name

        if object_name == "Post"
            puts "lasd"
            Notification.create(user_id: current_user.id, recipient_id: recipient_user.id,
                                message: current_user.name.capitalize + " mentioned you in a post",
                                noti_type: "post-mention",
                                noti_type_id: object.id,
                                mode:current_user.current_mode)
        end

        if object_name == "Comment"
            puts "comment"
            Notification.create(user_id: current_user.id, recipient_id: recipient_user.id,
                                message: current_user.name.capitalize + " mentioned you in a comment",
                                noti_type: "comment-mention",
                                noti_type_id: object.id,
                                mode:current_user.current_mode)
        end

        if object_name == "Reply"
            puts "reply"
            Notification.create(user_id: current_user.id, recipient_id: recipient_user.id,
                                message: current_user.name.capitalize + " mentioned you in a reply",
                                noti_type: "reply-mention",
                                noti_type_id: object.id,
                                mode:current_user.current_mode)
        end

    end

    def self.check_annonymous_post(object)
        if object.class.name == "Post"
            if object.anonymous?
                puts "false"
                false
            else
                puts "true"
                true
            end
        else
            puts "true"
            true
        end

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