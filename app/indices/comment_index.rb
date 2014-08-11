ThinkingSphinx::Index.define :comment, :with => :active_record do
  indexes commentText
  #has user_profile(:firstName) ,:as => :userName
  indexes user_profile_id ,:facet=>true
  indexes commentedBy , :facet=>true
end