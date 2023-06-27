connection: "thelook"

# include all the views
include: "/views/**/*.view"

datagroup: devoted_fields_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
#
persist_with: devoted_fields_default_datagroup


explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  #fields parameter for explores
  #https://cloud.google.com/looker/docs/reference/param-explore-fields

  #selecting some fields from 2 views:
  #fields: [orders.id, orders.status, orders.created_date]

  # all fields of all views using ALL_FIELDS
  #fields: [ALL_FIELDS*]

  # all fields of all views except one or more: -view.table
  fields: [ALL_FIELDS*, -users.country, -users.city]

  # all fields of a specyfic view
  #fields: [orders*]

  join: users {
    #fields parameter for join
    # https://cloud.google.com/looker/docs/reference/param-explore-join-fields
    #fields: [users.city, users.country, orders.created_date]

    # Using an empty list
    #fields: []

    #fields of a view
    #fields: [orders.status, users.age]

    #fields [ALL_FIELDS*]

    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
