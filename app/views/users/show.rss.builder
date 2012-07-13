xml.instruct! :xml , :version => "1.0"
xml.rss :version => "2.0" do 
		xml.channel do
		xml.title "Microposts from #{@user.name} | Sample App"
		xml.description "#{@user.name} Microposts"

							for micropost in @microposts
										xml.item do
										xml.title @user.name
										xml.description micropost.content
										xml.pubDate micropost.created_at.to_s(:rfc822)
										xml.link user_path(@user, :rss)
										end
							end
				end
end

