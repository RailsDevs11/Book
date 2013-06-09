Rails.application.config.middleware.use OmniAuth::Builder do
  #All social provider Secret key and Api key goes here
    
  provider :facebook, '174963659310800', 'a89a4ee12004caeca3dbded466e7cf53' if Rails.env == "development"
  provider :facebook, '387471341361431', '63c59314f1c055b161e52b9437827723' if Rails.env == "production"
  
  provider :google, '659163350122.apps.googleusercontent.com', '63jGhLosa0XUC6SnHb9iHwkQ' if Rails.env == "production"
  provider :google, '553652486409.apps.googleusercontent.com', 'L18pLETzIMu5avzbNKNdOb9l' if Rails.env == "development"
    
end
