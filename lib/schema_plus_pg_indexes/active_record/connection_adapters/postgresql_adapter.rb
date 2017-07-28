module SchemaPlusPgIndexes
  module ActiveRecord
    module ConnectionAdapters
      module PostgresqlAdapter
        #
        # SchemaPlusPgIndexes allows the column_names parameter
        # to be left off
        #
        def add_index(table_name, column_names, options={})

          constraint_deferrability = options.delete(:constraint_deferrability)

          column_names, options = [nil, column_names] if column_names.is_a? Hash

          if constraint_deferrability
            index_name, index_type, index_columns, _ = add_index_options(table_name, column_names, options)

            execute "alter table #{quote_table_name table_name}
            add constraint #{quote_column_name index_name} #{index_type} (#{index_columns})
            #{constraint_deferrability};"
          else
            super table_name, column_names, options
          end

        end
      end
    end
  end
end
