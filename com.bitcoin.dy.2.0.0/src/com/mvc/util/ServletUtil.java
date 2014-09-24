package com.mvc.util;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import com.mvc.config.Config;
import com.mvc.vo.CommonReply;
import com.mvc.vo.RetCode;

@Service
public class ServletUtil {
	private static final ObjectMapper jsonMapper = new ObjectMapper();
	public static void writeCommonReply(Object reply, RetCode ret, HttpServletResponse response) throws IOException {
		CommonReply commonReply = new CommonReply();
		commonReply.setRet(ret.code());
		commonReply.setMsg(ret.msg());
		String errorMsg = Config.getErrorMsg();
		if (!StringUtils.isEmpty(errorMsg)) {
			commonReply.setMsg(Config.getErrorMsg());
			Config.setErrorMsg("");
		}
		commonReply.setData(reply);
		writeObjectReply(commonReply, response);
	}
	public static String writeObjectReply(Object reply, HttpServletResponse response) throws IOException {
		Config.setRetCode(null);
		Config.setErrorMsg("");
		String replyStr = jsonString(reply);
		ServletUtil.httpResponse(200, replyStr, "application/json", "utf-8", response);
		return replyStr;
	}
	
	private static String jsonString(Object obj) throws IOException, JsonProcessingException {
		synchronized (jsonMapper) {
			return jsonMapper.writeValueAsString(obj);
		}
	}
	
	private static void httpResponse(int code, String msg, String contentType, String charset,
			HttpServletResponse response) throws IOException {
		response.setStatus(code);
		if (contentType != null) {
			response.setContentType(contentType);
		}
		response.setContentType("text/json;charset="+charset+"");
		byte[] bs = msg.getBytes(charset);
		response.setContentLength(bs.length);
		response.getOutputStream().write(bs);
		response.getOutputStream().flush();
	}
}
