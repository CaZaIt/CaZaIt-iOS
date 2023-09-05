//
//  APIContants.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/22.
//

import Foundation


struct APIConstants {
    // MARK: -  Base URL
    static let baseURL = "https://cazait.shop"
    
    // MARK: - Feature URL
    static let allCafeURL = baseURL + "/api/cafes/all" // 카페 전체 조회
    
    static let searchCafeURL = baseURL + "/api/cafes/name" // 카페 이름 조회
    
    static let detailCafeURL = baseURL + "/api/cafes" // 카페 ID 조회
    
    static let registerFavorites = baseURL + "/api/favorites/user" // 관심 카페 등록

    static let deleteFavorites = baseURL + "/api/favorites/delete" // 관심 카페 해제
    
    static let detailCafeMenuURL = baseURL + "/api/menus/cafe" // 카페 메뉴 조회
    
    static let cafeReviewURL = baseURL + "/api/reviews" // 카페 리뷰 조회 및 평점 조회
    
    static let writeReviewURL = baseURL + "/api/reviews/user" // 카페 리뷰 작성
    
    static let signupURL = baseURL + "/api/users/sign-up" // 회원가입
    
    static let nicknamecheckURL = baseURL + "/api/users/exist/nickname" // 닉네임 중복확인
    
    static let idCheckURL = baseURL + "/api/users/exist/accountname" // 아이디 중복확인
    
    static let loginURL = baseURL + "/api/auths/log-in?role=user" // 로그인(유저)
    
    static let favoritesURL = baseURL + "/api/favorites/user" //찜한매장확인
    
    static let refreshURL = baseURL + "/api/auths/refresh" //토큰 재발급
    
    static let phonenumberCheckURL = baseURL + "/api/users/exist/phonenumber" //전화번호 중복확인
    
    static let messageSendURL = baseURL + "/api/auths/send-authnumber/test" //인증번호 발송
    
    static let messageSendCheckURL = baseURL + "/api/auths/verify-authnumber" //인증번호 인증
    
    static let passwordCheckURL = baseURL + "/api/users/verify-password" //비밀번호 확인
    
    static let passwordChangeURL = baseURL + "/api/users/userinfo/password" //계정정보 관리에서 비밀번호 변경
    static let nickNameChangeURL = baseURL + "/api/users/userinfo/nickname" //계정정보 관리에서 닉네임 변경
    static let checkUserInfoURL = baseURL + "/api/users/reset-password/checkuserinfo" //유저정보(아이디+ 전화번호) 검증
    static let newPasswordCangeURL = baseURL + "/api/users/reset-password/password" //로그인 전 비밀번호 찾기를 통한 새 비밀번호 발급
    static let notifyIdURL = baseURL + "/api/users/find-accountname" //유저 계정 아이디 찾기
}
