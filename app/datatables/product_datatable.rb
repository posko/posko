class ProductDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :number_to_currency
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      title: { source: 'Product.title', cond: :like },
      product_type: { source: 'Product.product_type', cond: :like },
      status: { source: 'Product.status', cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        title: record.decorate.title_link,
        product_type: record.product_type.humanize,
        price: number_to_currency(record.price, unit: 'P '),
        cost: number_to_currency(record.cost, unit: 'P '),
        status: record.status.humanize,
        actions: actions(record)
      }
    end
  end

  private

  def actions(record)
    ProductsController.render(partial: 'actions', locals: { product: record })
  end

  def get_raw_records
    options[:current_account].products.active_status
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
