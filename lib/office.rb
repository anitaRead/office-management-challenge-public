class Office

    attr_reader :meeting_rooms, :rooms_in_use

    def initialize
       @meeting_rooms = {}
       @rooms_in_use = []

    end

    def add_meeting_room(meeting_name)
        @meeting_rooms[meeting_rooms.length + 1] = meeting_name
    end

    def is_room_available?(room_number)
        matching_room = @meeting_rooms.keys.select { |i| i == room_number }
        matching_room.length == 1 && !@rooms_in_use.include?(room_number)

    end

    def enter_room(room_number)
        raise 'Room is already in use!' if @rooms_in_use.include?(room_number) 
        @rooms_in_use << room_number
    end

    def exit_room(room_number)
        @rooms_in_use.delete(room_number)
    end

    def available_rooms
        @meeting_rooms.select { |room| !@rooms_in_use.include?(room) }
    end
end