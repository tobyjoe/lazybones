class Sizing < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER

  property :size
  property :product_name

  view_by :size, :product_name

  view_by :product_name,
    :map => 
      "function(doc) {
        if (doc['couchrest-type'] == 'Sizing') {
          if (doc.product_name == 'Vans Half-Cab'){
            emit(doc.product_name, doc.size);
          };
        }
      }",
    :reduce => 
      "function(keys, values, rereduce) {
        return sum(values);
      }"

  timestamps!

end