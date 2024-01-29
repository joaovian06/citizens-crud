module CitizensHelper
    def citizens_statuses_for_select
        Citizen.statuses.keys.map do |k|
            [Citizen.human_attribute_name("status.#{k}"), k]
        end
    end
end
