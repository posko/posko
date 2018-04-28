class UserDatatable < AjaxDatatablesRails::Base
  def_delegator :@view, :link_to
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name: { source: "User.first_name", cond: :like },
      email: { source: "User.email", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        # example:
        name: name(record),
        email: record.email,
        actions: actions(record)
      }
    end
  end

  private
  def actions record
    ""
  end
  def name record
    link_to record.name, record
  end
  def get_raw_records
    options[:current_account].users.active_status
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
