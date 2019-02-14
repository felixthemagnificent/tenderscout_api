namespace :summary do
  desc "Send a summary email"
  task :email,  [:user_id] => [:environment] do |t, args|
    weekly_new_tenders_count = ActiveSupport::NumberHelper.number_to_delimited(Core::Tender.where('created_at > ?', DateTime.now - 1.week).count)
    all_tenders_count = ActiveSupport::NumberHelper.number_to_delimited(Core::Tender.all.count)
    
    User.all.each do |user|
      p "Making results for user #{user.profiles.first.fullname}"
      begin
        monitors = user.search_monitors
        ids = []
        monitors.each do |e|
          ids += e.results.map {|e| e.attributes['id']} .map(&:to_i) 
        end
        ids.uniq!
        results = Core::Tender.where('created_at >= ?',(DateTime.now - 1.week)).where(id: ids).last(10)
        p "Found #{results.count} tenders"
        if results.count
          tenders = []
          results.each do |e| 
            tenders << { 
              title: e.title, 
              url: Rails.configuration.mailer['tender_details_url'] % {id: e.id},
              buyer_name: e.try(:creator).try(:profiles).try(:first).try(:fullname) || e.try(:organization).try(:name),
              submission_date: e.try(:submission_date).try(:strftime,'%m.%d.%Y'),
              tender_description: ((e.description[0..200] + '...') rescue '')
            }  
          end

          configuration = {
              user_name: user.profiles.first.fullname,
              summary_day: DateTime.now.strftime('%m.%d.%Y'),
              all_results_url: Rails.configuration.mailer['all_results_url'],
              tenders: tenders,
              user_profile_type: user.profiles.first.profile_type,
              user_profile_link: Rails.configuration.mailer['profiles_url'] % {id: user.profiles.first.id},
              product_url: Rails.configuration.mailer['product_url'],
              support_url: Rails.configuration.mailer['support'],
              company_address: Rails.configuration.mailer['company_address'],
              all_tenders_count: all_tenders_count,
              weekly_new_tenders_count: weekly_new_tenders_count,
              upgrade_url: Rails.configuration.mailer['upgrade_url']
            }
          if %w(standard basic).include?(user.role)
            configuration[:role_standart] =  1
          elsif user.role == 'free'
            configuration[:role_free] = 1
          end

          CustomPostmarkMailer.template_email(
            user.email,
            Rails.configuration.mailer['templates']['summary_tenders'],
            configuration
          ).deliver_later
        else
          configuration = {
              user_name: user.profiles.first.fullname,
              summary_day: DateTime.now.strftime('%m.%d.%Y'),
              user_profile_type: user.profiles.first.profile_type,
              user_profile_link: Rails.configuration.mailer['profiles_url'] % {id: user.profiles.first.id},
              product_url: Rails.configuration.mailer['product_url'],
              support_url: Rails.configuration.mailer['support'],
              company_address: Rails.configuration.mailer['company_address'],
              all_tenders_count: Core::Tender.all.count,
              weekly_new_tenders_count: Core::Tender.where('created_at > ?', DateTime.now - 1.week).count,
              upgrade_url: Rails.configuration.mailer['upgrade_url']
            }
          if %w(standard basic).include?(user.role)
            configuration[:role_standart] =  1
          elsif user.role == 'free'
            configuration[:role_free] = 1
          end
          CustomPostmarkMailer.template_email(
            user.email,
            Rails.configuration.mailer['templates']['empty_summary_tenders'],
            configuration
          ).deliver_later
        end
      rescue
        p "Error making results for user #{user.profiles.first.fullname}"
      end
    end
  end
end
