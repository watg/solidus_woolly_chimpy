module Spree::Chimpy
  module Interface
    class Orders
      delegate :log, to: Spree::Chimpy

      def initialize(key)
        @api = Mailchimp::API.new(key, Spree::Chimpy::Config.api_options)
      end

      def add(order)
        log "Adding order #{order.number}"

        @api.ecomm_order_add(order: hash(order))
      end

      def remove(order)
        log "Attempting to remove order #{order.number}"

        @api.ecomm_order_del(store_id: Config.store_id, order_id: order.number)
      end

      def sync(order)
        remove(order)
        add(order)
      end

    private
      def hash(order)
        source = order.source

        items = order.line_items.map do |line|
          variant = line.variant
          ptaxon = Spree::Taxonomy.find_by_name("Categories")
          taxon_id = variant.product.taxons.where(:parent_id => ptaxon.id).uniq.map(&:id).first
          taxon_name = variant.product.taxons.where(:id => taxon_id).uniq.map(&:name).first

          {product_id:    variant.id,
           sku:           variant.sku,
           product_name:  variant.name,
           category_id:   taxon_id,
           category_name: taxon_name,
           cost:          variant.cost_price.to_f,
           qty:           line.quantity}
        end

        data = {
          id:          order.number,
          email:       order.email,
          total:       order.total.to_f,
          order_date:  order.completed_at,
          shipping:    order.ship_total.to_f,
          tax:         order.tax_total.to_f,
          store_name:  Spree::Config.site_name,
          store_id:    Spree::Chimpy::Config.store_id,
          items:       items
        }

        if source
          data[:email_id]    = source.email_id
          data[:campaign_id] = source.campaign_id
        end

        data
      end

    end
  end
end
