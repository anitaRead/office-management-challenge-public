require 'office'

describe Office do
    # As a staff member
    # In order to distinguish between meeting rooms
    # I would like my meeting room to have a name

    it 'checks meeting room has a name' do
        office = Office.new
        office.add_meeting_room('Team check in')
        expect(office.meeting_rooms).to eq({1 => 'Team check in'})
    end

    # As an office manager
    # So that staff can coordinate meetings
    # I would like to add a meeting room to the office

    it 'adds a meeting room to the office' do
        office = Office.new
        expect{ office.add_meeting_room('Team check in') }.not_to raise_error
        expect(office.meeting_rooms).to eq({ 1 => 'Team check in'})
    end

    # As an office manager
    # So that I can manage meeting rooms
    # I would like to list all the meeting rooms in the office

    it 'lists all the meeting rooms in the office' do
        office = Office.new
        office.add_meeting_room('Team check in')
        office.add_meeting_room('Party planning committee')
        office.add_meeting_room('Conference')
        office.add_meeting_room('End of week meeting')
        expect(office.meeting_rooms).to eq({1 => 'Team check in', 2 => 'Party planning committee', 3 => 'Conference', 4 => 'End of week meeting'})
    end

    # As a staff member
    # In order to have meeting,
    # I would like to check if the meeting room is available or not (true or false)

    it 'checks if a meeting room is available' do
        office = Office.new
        office.add_meeting_room('Team check in')
        office.add_meeting_room('Party planning committee')
        office.add_meeting_room('Conference')
        expect(office.is_room_available?(2)).to eq true
    end

    # As a staff member
    # In order to have a meeting,
    # I would like to be able to enter the meeting room and this should make it unavailable

    it 'makes room unavailable when in use' do
        office = Office.new
        office.add_meeting_room('Team check in')
        office.add_meeting_room('Party planning committee')
        office.add_meeting_room('Conference')
        office.enter_room(1)
        expect(office.is_room_available?(1)).to eq false
        expect(office.is_room_available?(3)).to eq true
    end

    # As a staff member
    # In order to end a meeting
    # I would like to be able to leave the meeting room and this should make it available again

    it 'makes room available when not in use' do
        office = Office.new
        office.add_meeting_room('Team check in')
        office.add_meeting_room('Party planning committee')
        office.add_meeting_room('Conference')
        office.enter_room(1)
        office.enter_room(2)
        office.exit_room(1)
        expect(office.is_room_available?(1)).to eq true
        expect(office.is_room_available?(2)).to eq false
    end
     
    # As a staff member
    # So that I can see where to have my meeting
    # I would like to be able to see a list of available rooms in the office

    it 'can list all available rooms in the office' do
       office = Office.new
       office.add_meeting_room('Team check in')
       office.add_meeting_room('Party planning committee')
       office.add_meeting_room('Conference')
       office.add_meeting_room('Coffee chat')
       office.enter_room(1)
       office.enter_room(2)
       expect(office.available_rooms).to eq({3 => 'Conference', 4 => 'Coffee chat'})
    end

    # As a staff member
    # So that I can avoid interrupting a meeting
    # I would like an error if I try to use a room that has already been entered

    it 'raises an error when user tries to enter a room, which is in use' do
       office = Office.new
       office.add_meeting_room('Team check in')
       office.add_meeting_room('Party planning committee')
       office.add_meeting_room('Conference')
       office.enter_room(1)
       expect{ office.enter_room(1) }.to raise_error 'Room is already in use!'
    end
end