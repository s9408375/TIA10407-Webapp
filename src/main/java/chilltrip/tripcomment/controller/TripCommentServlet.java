package chilltrip.tripcomment.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import chilltrip.tripcomment.model.TripCommentService;
import chilltrip.tripcomment.model.TripCommentVO;

@MultipartConfig
@WebServlet("/back-end/trip-comment/comment.do")
public class TripCommentServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// 將此集合儲存在請求範圍中，以備需要時使用
			// 傳送 ErrorPage
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("tripCommentId");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入行程留言ID");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/trip-comment/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Integer tripCommentId = null;
			try {
				tripCommentId = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("行程留言ID格式不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/trip-comment/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2.開始查詢資料 *****************************************/
			TripCommentService tripCommentService = new TripCommentService();
			TripCommentVO tripCommentVO = tripCommentService.getTripComment(tripCommentId);
			if (tripCommentVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/trip-comment/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("tripCommentVO", tripCommentVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/trip-comment/listOneCom.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneCom.jsp
			successView.forward(req, res);
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllCom.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			Integer tripCommentId = Integer.valueOf(req.getParameter("tripCommentId"));

			/*************************** 2.開始查詢資料 ****************************************/
			TripCommentService tripCommentService = new TripCommentService();
			TripCommentVO tripCommentVO = tripCommentService.getTripComment(tripCommentId);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("tripCommentVO", tripCommentVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/trip-comment/update_com_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer tripCommentId = Integer.valueOf(req.getParameter("tripCommentId").trim());

			String memberId = req.getParameter("memberId");
			Integer memberId2 = null;
			if (memberId == null || memberId.trim().isEmpty()) {
				errorMsgs.add("會員ID: 請勿空白");
			} else if (memberId.matches("[0-9]+")) {
				try {
					memberId2 = Integer.valueOf(memberId);
				} catch (NumberFormatException e) {
					errorMsgs.add("會員ID 格式錯誤");
				}
			} else {
				errorMsgs.add("會員ID只能是數字");
			}

			String tripId = req.getParameter("tripId");
			Integer tripId2 = null;
			if (tripId == null || tripId.trim().isEmpty()) {
				errorMsgs.add("行程ID: 請勿空白");
			} else if (tripId.matches("[0-9]+")) {
				try {
					tripId2 = Integer.valueOf(tripId);
				} catch (NumberFormatException e) {
					errorMsgs.add("行程ID 格式錯誤");
				}
			} else {
				errorMsgs.add("行程ID只能是數字");
			}

			TripCommentVO tripCommentVO = new TripCommentVO();

			// 將有效的 memberId2 和 tripId2 設定到 VO
			if (memberId2 != null) {
				tripCommentVO.setMemberId(memberId2);
			} else {
				errorMsgs.add("無效的會員ID");
			}

			if (tripId2 != null) {
				tripCommentVO.setTripId(tripId2);
			} else {
				errorMsgs.add("無效的行程ID");
			}

			Integer score = null;
			try {
				score = Integer.valueOf(req.getParameter("score").trim());
			} catch (NumberFormatException e) {
				score = 0;
				errorMsgs.add("請評分星星數");
			}

			// 處理圖片上傳
			byte[] photo = null; // 默認值為 null

			Part filePart = req.getPart("photo");
			if (filePart != null) {
				
				String fileName = filePart.getSubmittedFileName();
				
				if (fileName != null && !fileName.isEmpty()) {
					// 設置圖片存儲路徑
					String path = getServletContext().getRealPath("/") + "resource" + File.separator + "images"
							+ File.separator + fileName;

					// 確保目錄存在
					File uploadDir = new File(
							getServletContext().getRealPath("/") + "resource" + File.separator + "images");

					if (!uploadDir.exists()) {
						uploadDir.mkdir(); // 若不存在，則創建該目錄
					}

					// 處理文件寫入
					InputStream inputStream = null;
					FileOutputStream outputStream = null;
					try {
						inputStream = filePart.getInputStream();
						outputStream = new FileOutputStream(path);

						byte[] buffer = new byte[1024];
						int bytesRead;
						while ((bytesRead = inputStream.read(buffer)) != -1) {
							outputStream.write(buffer, 0, bytesRead);
						}
						// 讀取檔案為 byte[]
						photo = new byte[(int) filePart.getSize()];
						inputStream.read(photo);  // 將圖片資料讀入 byte[]

					} catch (IOException e) {

						e.printStackTrace();

					} finally {
						try {
							if(outputStream != null){
								outputStream.close();
							}
							if(inputStream != null){
								inputStream.close();
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}
			}

			java.sql.Timestamp createTime = null;
			try {
				createTime = java.sql.Timestamp.valueOf(req.getParameter("createTime").trim());
			} catch (IllegalArgumentException e) {
				createTime = new java.sql.Timestamp(System.currentTimeMillis());
				errorMsgs.add("請輸入日期");
			}

			String content = null;
			try {
				content = String.valueOf(req.getParameter("content").trim());
			} catch (NumberFormatException e) {
				content = "";
				errorMsgs.add("請填寫留言");
			}


			tripCommentVO.setTripCommentId(tripCommentId);
			tripCommentVO.setMemberId(memberId2);
			tripCommentVO.setTripId(tripId2);
			tripCommentVO.setScore(score);
			tripCommentVO.setPhoto(photo);
			tripCommentVO.setCreateTime(createTime);
			tripCommentVO.setContent(content);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("tripCommentVO", tripCommentVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/trip-comment/update_com_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			TripCommentService tripCommentService = new TripCommentService();
			tripCommentVO = tripCommentService.updateTripComment(tripCommentId, memberId2, tripId2, score, photo,
					createTime, content);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("tripCommentVO", tripCommentVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back-end/trip-comment/listOneCom.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneCom.jsp
			successView.forward(req, res);
		}

		if ("insert".equals(action)) { // 來自addCom.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			
			String memberId = req.getParameter("memberId");
			Integer memberId2 = null;
			if (memberId == null || memberId.trim().isEmpty()) {
				errorMsgs.add("會員ID: 請勿空白");
			} else if (memberId.matches("[0-9]+")) {
				try {
					memberId2 = Integer.valueOf(memberId);
				} catch (NumberFormatException e) {
					errorMsgs.add("會員ID 格式錯誤");
				}
			} else {
				errorMsgs.add("會員ID只能是數字");
			}

			String tripId = req.getParameter("tripId");
			Integer tripId2 = null;
			if (tripId == null || tripId.trim().isEmpty()) {
				errorMsgs.add("行程ID: 請勿空白");
			} else if (tripId.matches("[0-9]+")) {
				try {
					tripId2 = Integer.valueOf(tripId);
				} catch (NumberFormatException e) {
					errorMsgs.add("行程ID 格式錯誤");
				}
			} else {
				errorMsgs.add("行程ID只能是數字");
			}

			TripCommentVO tripCommentVO = new TripCommentVO();

			// 將有效的 memberId2 和 tripId2 設定到 VO
			if (memberId2 != null) {
				tripCommentVO.setMemberId(memberId2);
			} else {
				errorMsgs.add("無效的會員ID");
			}

			if (tripId2 != null) {
				tripCommentVO.setTripId(tripId2);
			} else {
				errorMsgs.add("無效的行程ID");
			}

			Integer score = null;
			try {
				score = Integer.valueOf(req.getParameter("score").trim());
			} catch (NumberFormatException e) {
				score = 0;
				errorMsgs.add("請評分星星數");
			}

			// 處理圖片上傳
			byte[] photo = null; // 默認值為 null

			Part filePart = req.getPart("photo");
			if (filePart != null) {
				
				String fileName = filePart.getSubmittedFileName();
				
				if (fileName != null && !fileName.isEmpty()) {
					// 設置圖片存儲路徑
					String path = getServletContext().getRealPath("/") + "resource" + File.separator + "images"
							+ File.separator + fileName;

					// 確保目錄存在
					File uploadDir = new File(
							getServletContext().getRealPath("/") + "resource" + File.separator + "images");

					if (!uploadDir.exists()) {
						uploadDir.mkdir(); // 若不存在，則創建該目錄
					}

					// 處理文件寫入
					InputStream inputStream = null;
					FileOutputStream outputStream = null;
					try {
						inputStream = filePart.getInputStream();
						outputStream = new FileOutputStream(path);

						byte[] buffer = new byte[1024];
						int bytesRead;
						while ((bytesRead = inputStream.read(buffer)) != -1) {
							outputStream.write(buffer, 0, bytesRead);
						}
						// 讀取檔案為 byte[]
						photo = new byte[(int) filePart.getSize()];
						inputStream.read(photo);  // 將圖片資料讀入 byte[]

					} catch (IOException e) {

						e.printStackTrace();

					} finally {
						try {
							if(outputStream != null){
								outputStream.close();
							}
							if(inputStream != null){
								inputStream.close();
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}
			}

			java.sql.Timestamp createTime = null;
			try {
				createTime = java.sql.Timestamp.valueOf(req.getParameter("createTime").trim());
			} catch (IllegalArgumentException e) {
				createTime = new java.sql.Timestamp(System.currentTimeMillis());
				errorMsgs.add("請輸入日期");
			}

			String content = null;
			try {
				content = String.valueOf(req.getParameter("content").trim());
			} catch (NumberFormatException e) {
				content = "";
				errorMsgs.add("請填寫留言");
			}

			tripCommentVO.setMemberId(memberId2);
			tripCommentVO.setTripId(tripId2);
			tripCommentVO.setScore(score);
			tripCommentVO.setPhoto(photo);
			tripCommentVO.setCreateTime(createTime);
			tripCommentVO.setContent(content);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("tripCommentVO", tripCommentVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/trip-comment/addCom.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始新增資料 ***************************************/
			TripCommentService tripCommentService = new TripCommentService();
			tripCommentVO = tripCommentService.addTripComment(memberId2, tripId2, score, photo,
					createTime, content);

			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/back-end/trip-comment/listAllCom.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCom.jsp
			successView.forward(req, res);
		}

		if ("delete".equals(action)) { // 來自listAllCom.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ***************************************/
			Integer tripCommentId = Integer.valueOf(req.getParameter("tripCommentId"));

			/*************************** 2.開始刪除資料 ***************************************/
			TripCommentService tripCommentService = new TripCommentService();
			tripCommentService.deleteTripComment(tripCommentId);

			/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
			String url = "/back-end/trip-comment/listAllCom.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);
		}
	}
}
