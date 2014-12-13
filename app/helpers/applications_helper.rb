module ApplicationsHelper
  
  def get_Application_Count()
    applications = Application.all
    count = 0
    if applications
      count = applications.count
    end
    count
  end

  def get_Application_Name(id)
    application = Application.find_by_id(id)
    application.name
  end

  def get_Application_Schemas_List(id)
    set_internal_database()
    schemaList = ""
    schemas = Schema.where("application_id >= '#{id}'")
    schemas.each do |s|
      if !schemaList.include? s.name
        schemaList << s.name + ", "
      end
    end
    if schemaList == ""
      return "No schemas defined and/or associated."
    else
      return schemaList.chop.chop
    end
  end

  def user_can_status(schema_id)
    credentials = Credential.where("schema_id = '#{schema_id}' AND user_id = '#{session[:user_id]}'")
    if credentials == nil 
      return false
    end
    credentials.each do |credential|
      if credential.status == true
        return true
      else
        return false
      end
    end
  end

  def user_can_snapshot(schema_id)
    credentials = Credential.where("schema_id = '#{schema_id}' AND user_id = '#{session[:user_id]}'")
    if credentials == nil 
      return false
    end
    credentials.each do |credential|
      if credential.snapshot == true
        return true
      else
        return false
      end
    end
  end

  def user_can_forecast(schema_id)
    credentials = Credential.where("schema_id = '#{schema_id}' AND user_id = '#{session[:user_id]}'")
    if credentials == nil 
      return false
    end
    credentials.each do |credential|
      if credential.forecast == true
        return true
      else
        return false
      end
    end
  end

  def user_can_deploy(schema_id)
    credentials = Credential.where("schema_id = '#{schema_id}' AND user_id = '#{session[:user_id]}'")
    if credentials == nil 
      return false
    end
    credentials.each do |credential|
      if credential.deploy == true
        return true
      else
        return false
      end
    end
  end
  
end
