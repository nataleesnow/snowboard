class TransactionRow < RowWrapper

  COLUMNS = [ "day", "begin_time", "lift",  "vert"]

  wrap(COLUMNS)

end

