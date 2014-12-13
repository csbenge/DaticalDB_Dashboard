module CredentialsHelper

	include SchemasHelper

	def get_Credential_Badge(state)
		if state == true
      return "<big><span class='label label-success'>Yes</span></big>"
    else
      return "<big><span class='label label-danger'>No</span></big>"
    end
	end

	def get_User_Name(id)
		user = User.find_by_id(id)
		user.name
	end

	def get_Schema_Name(id)
		schema = Schema.find_by_id(id)
		schema.name
	end

	def get_Application_Name_via_SchemaID(schema_id)
		schema = Schema.find_by_id(schema_id)
    application = Application.find_by_id(schema.application_id)
    application.name
  end

  def get_Environment_Name_via_SchemaID(schema_id)
		schema = Schema.find_by_id(schema_id)
    environment = Environment.find_by_id(schema.environment_id)
    environment.name
  end

end
