staff_members = StaffMember.all

256.times do |n|
  member = staff_members.sample
  event = member.events.build
  if member.active?
    if n.even?
      event.type = 'logged_in'
    else
      event.type = 'logged_out'
    end
  else
    event.type = 'rejected'
  end
  event.occurred_at = (256 - n).hours.ago
  event.save!
end
