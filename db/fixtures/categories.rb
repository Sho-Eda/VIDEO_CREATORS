
Category.seed(:id,
  {:id=>1, :name=>"Artists", :ancestry=>nil},
  {:id=>2, :name=>"Category", :ancestry=>nil},
  {:id=>3, :name=>"Director", :ancestry=>"1"},
  {:id=>4, :name=>"Videographer", :ancestry=>"1"},
  {:id=>5, :name=>"Editor", :ancestry=>"1"},
  {:id=>6, :name=>"Compositor", :ancestry=>"1"},
  {:id=>7, :name=>"Motion Graphicker", :ancestry=>"1"},
  {:id=>8, :name=>"Colorist", :ancestry=>"1"},
  {:id=>9, :name=>"After Effects", :ancestry=>"2"},
  {:id=>10, :name=>"Premiere pro", :ancestry=>"2"},
  {:id=>11, :name=>"Composite", :ancestry=>"2"},
  {:id=>12, :name=>"Color Grading", :ancestry=>"2"},
  {:id=>13, :name=>"Shoot", :ancestry=>"2"},
  {:id=>14, :name=>"Motion Graphics", :ancestry=>"2"}
)