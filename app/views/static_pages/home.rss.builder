xml.instruct! :xml , :version => "1.0"
xml.rss :version => "2.0" do 
		xml.channel do
		xml.title "RSS Feed for #{current_user.name}"
		xml.description "RSS Feed for #{current_user.name} on sample application"

							for micropost in @feed_items
										xml.item do
										xml.title micropost.user.name
										xml.description micropost.content
										xml.pubDate micropost.created_at.to_s(:rfc822)
										xml.link user_path(micropost.user)
										end
							end
				end
end
