package com.siping.web.utility.limit;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



import com.ibatis.sqlmap.engine.execution.SqlExecutor;
import com.ibatis.sqlmap.engine.mapping.statement.RowHandlerCallback;
import com.ibatis.sqlmap.engine.scope.StatementScope;
import com.siping.web.utility.limit.dialect.Dialect;

public class LimitSqlExecutor extends SqlExecutor {
	
	private static final Log logger=LogFactory.getLog(LimitSqlExecutor.class);
	
	private boolean enableLimit=true;

	private Dialect dialect;
	
	public boolean isEnableLimit() {
		return enableLimit;
	}

	public void setEnableLimit(boolean enableLimit) {
		this.enableLimit = enableLimit;
	}

	public Dialect getDialect() {
		return dialect;
	}

	public void setDialect(Dialect dialect) {
		this.dialect = dialect;
	}

	//@Override
	public void executeQuery(StatementScope request, Connection conn, String sql,
			Object[] parameters, int currentPage, int pageSize, RowHandlerCallback callback)
			throws SQLException {
		
		if( (currentPage != NO_SKIPPED_RESULTS || pageSize != NO_MAXIMUM_RESULTS) && supportsLimit() )
		{
			sql = dialect.getLimitString(sql, currentPage, pageSize);
			
			if(logger.isDebugEnabled())
			{
				logger.debug(sql);
			}
			// aibi更改
			//currentPage = NO_SKIPPED_RESULTS;
			//pageSize = NO_MAXIMUM_RESULTS;
		}
		super.executeQuery(request, conn, sql, parameters, currentPage, pageSize, callback);
	}

	
	public boolean supportsLimit(){
		if(enableLimit&&dialect!=null)
		{
			return dialect.supportsLimit();
		}
		return false;
	}
}
