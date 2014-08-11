ThinkingSphinx::Index.define :user_profile, :with => :active_record do
  indexes secondName ,address,userName,emailId,id
  indexes firstName ,:sortable => true
  indexes education

  indexes comments(:id) ,:as=>:comment,:facet =>true
 # has id
 # has "CRC32(userName)",as: :userName, type: :integer
  set_property :min_infix_len => 3
  set_property :blend_chars => '@'
end