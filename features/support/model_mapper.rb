module ModelMapper
  def model_for(records)
    case records
      when /athletes/i
        Athlete
      when /events/i
        Event
      when /registrations/i
        Registration
      when /rfids/i
        Rfid
      when /skating results/i
        SkatingResult
      when /teams/i
        Team
    else
      begin
        the_model = records.camelize.chop.constantize
        return the_model
      rescue StandardError
        raise "Can't map #{records} to a database table."
      end
    end
  end
end

World(ModelMapper)
