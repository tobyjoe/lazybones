class User < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER

  property :sizings
  property :user_name
  property :slug

  unique_id :slug

  view_by :user_name, :product_name

  view_by :user_name,
    :map => 
      "function(doc) {
        var hasReference = false;
        var hasTarget = false;
        var targetSize = null;
        if (doc['couchrest-type'] == 'User' && doc.user_name != 'TobyJoe' && doc.sizings.length > 1) {
          for(var sizing in doc.sizings){
            s = doc.sizings[sizing];
            if (s.product_name == 'Vans Half-Cab' && s.size == 9) {
              hasReference = true;
              continue;
            }
            if (s.product_name == 'Dunks') {
              hasTarget = true;
              targetSize = s.size;
            }
          }
          if(hasReference && hasTarget){
            emit(doc.user_name, targetSize);
          }
        }
      }",
    :reduce => 
      "function(keys, values, rereduce) {
        return values;
      }"  

  timestamps!

  save_callback :before, :generate_slug

  def generate_slug
    s = "#{user_name}"
    self['slug'] = s.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^\-|\-$/,'') if new_document?
  end
  
  def add_sizing(sizing)
    self.sizings = [] if self.sizings.nil?
    self.sizings << sizing
  end
end