module Bidsense

  def self.score(profile: nil, tender: nil, search_monitor: nil)
    result = { budget: -1, geography: -1, subject: -1, incumbent: -1, time: -1, buyer_related: -1 }

    tender_range = if tender.award_value.to_i > 0 
        [tender.award_value.to_i, tender.award_value.to_i] 
      else
        [tender.estimated_low_value.to_i, tender.estimated_high_value.to_i ]
      end
    profile_range = [profile.valueFrom, profile.valueTo]

    if (profile_range.first <= tender_range.first) and (tender_range.second <= profile_range.second) #tender budget lyes in profile
      result[:budget] = 3
    elsif (profile_range.first*0.8 <= tender_range.first and profile_range.first > tender_range.first) or (tender_range.second > profile_range.second and tender_range.second <= profile_range.second*1.2)
      result[:budget] = 2
    else      
      result[:budget] = 1
    end

    if (profile.country == tender.country)
      result[:geography] = 3
    else
      result[:geography] = 2
    end

    if search_monitor
      tender_keywords = tender.keywords
      search_keywords = search_monitor.keywordList
      same_keywords = tender_keywords - (search_keywords + tender_keywords - search_keywords)
      result[:subject] = if same_keywords.count >= 2
          3
        elsif same_keywords.count == 1
          2
        else
          1
        end
    end
    if tender.deadline_date
      date_difference = (tender.deadline_date - DateTime.now).to_i   
      date_difference = 0 if date_difference < 0

      result[:date] = if date_difference > 25
        3
      elsif date_difference >= 15 and date_difference <= 25
        2
      else
        1
      end
    end
        
    result
  end
end