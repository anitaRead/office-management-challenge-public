require 'office'

describe Office do 
    subject(:office) { described_class.new }
    let(:meeting_name) { double :meeting_name }
    let(:meeting_name_2) { double :meeting_name_2 }
    
    it 'adds a meeting room' do
        expect{ office.add_meeting_room(meeting_name) }.not_to raise_error
    end

    it 'adds multiple meeting rooms' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name)
        expect(office.meeting_rooms).to eq({1 => meeting_name, 2 => meeting_name, 3 => meeting_name})
    end

    it 'checks for a meeting name' do
        office.add_meeting_room(meeting_name)
        expect(office.meeting_rooms).to eq({ 1 => meeting_name })
    end

    it 'checks for a specific meeting name in a list' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        expect(office.meeting_rooms[2]).to eq(meeting_name_2)
    end

    it 'lists all meeting rooms' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        expect(office.meeting_rooms).to eq({ 1 => meeting_name, 2 => meeting_name_2, 3 => meeting_name, 4 => meeting_name_2})
    end

    it 'checks if a meeting room is available' do
        office.add_meeting_room(meeting_name)
        expect(office.is_room_available?(1)).to eq true
    end

    it 'checks if a meeting room is not available' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        expect(office.is_room_available?(3)).to eq false
    end

    it 'can enter a room' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        expect{ office.enter_room(1) }.not_to raise_error
    end

    it 'marks room as unavailable when in use' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.enter_room(1)
        expect(office.is_room_available?(1)).to eq false
        expect(office.is_room_available?(2)).to eq true
    end

    it 'can exit a room' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.enter_room(2)
        expect{ office.exit_room(2) }.not_to raise_error
    end

    it 'marks room as unavailable when not in use' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.enter_room(2)
        office.exit_room(2)
        expect(office.is_room_available?(2)).to eq true
    end

    it 'checks rooms in use' do 
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.add_meeting_room(meeting_name)
        office.enter_room(1)
        office.enter_room(2)
        office.exit_room(1)
        expect(office.rooms_in_use).to eq([2])
    end

    it 'lists all available rooms' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.add_meeting_room(meeting_name)
        office.enter_room(1)
        expect(office.available_rooms).to eq({ 2 => meeting_name_2, 3 => meeting_name})
    end

    it 'raises an error when user tries to enter a room in use' do
        office.add_meeting_room(meeting_name)
        office.add_meeting_room(meeting_name_2)
        office.enter_room(2)
        expect{ office.enter_room(2) }.to raise_error 'Room is already in use!'
    end
end