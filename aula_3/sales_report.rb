class SalesReport
    include Enumerable

    def initialize(sales)
        @sales = sales
    end

    def each(&block)
        @sales.each(&block)
    end

    def total_by_category
        @sales.group_by { |s| s[:category] }
                    .transform_values { |items| items.sum { |s| s[:amount] } }
    end

    def top_sales(n)
        @sales.max_by(n) { |s| s[:amount] }
    end

    def grouped_by_category
        @sales.group_by { |s| s[:category] }
                 .transform_values { |items| items.map { |s| s[:product] } }
    end

    def above_average_sales
        avg = @sales.sum { |s| s[:amount] } / @sales.size.to_f
        @sales.select { |s| s[:amount] > avg }
    end
end