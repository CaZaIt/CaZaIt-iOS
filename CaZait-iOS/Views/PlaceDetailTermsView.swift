//
//  PlaceDetailTermsView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/07/31.
//

import Foundation
import UIKit
import SnapKit

class PlaceDetailTermsView: UIViewController, UIGestureRecognizerDelegate{
    
    var textView: UITextView!
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 바 타이틀 설정
        self.title = "위치정보 기반 서비스 이용약관"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        //손가락 옆으로 미는 제스쳐 작동
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // 긴 텍스트 설정
        let longText = """
                위치정보 기반 서비스 이용약관
                
                제1조 목적본 약관은 주식회사 카카오엔터테인먼트(이하 “회사”)가 제공하는 위치기반서비스에 대해 회사와 위치기반서비스를 이용하는 개인위치정보주체(이하“이용자”)간의 권리·의무 및 책임사항, 기타 필요한 사항 규정을 목적으로 합니다.
                제2조 이용약관의 효력 및 변경
                ① 본 약관은 이용자가 본 약관에 동의하고 회사가 정한 절차에 따라 위치기반서비스의 이용자로 등록됨으로써 효력이 발생합니다.
                ② 이용자가 온라인에서 본 약관의 "동의하기" 버튼을 클릭하였을 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다.
                ③ 회사는 법률이나 위치기반서비스의 변경사항을 반영하기 위한 목적 등으로 약관을 수정할 수 있습니다.
                ④ 약관이 변경되는 경우 회사는 변경사항을 그 적용일자 최소 7일 전에 회사의 홈페이지 또는 서비스 공지사항 등(이하, 홈페이지 등)을 통해 공지합니다.다만, 개정되는 내용이 이용자 권리의 중대한 변경을 발생시키는 경우 적용일 최소 30일 전에 홈페이지 등에 공지합니다.
                ⑤ 회사가 전항에 따라 이용자에게 통지하면서 공지 또는 통지·고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 이용약관에 승인한 것으로 봅니다. 이용자가 개정약관에 동의하지 않을 경우 본 약관에 대한 동의를 철회할 수 있습니다.
                제3조 약관 외 준칙이 약관에 명시되지 않은 사항에 대해서는 위치정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 전기통신사업법,정보통신망 이용 촉진 및 보호 등에 관한 법률 등 관계법령 및 회사가 정한 지침 등의 규정에 따릅니다.
                제4조 서비스의 내용회사는 위치정보사업자로부터 수집한 이용자의 현재 위치 또는 현재 위치가 포함된 지역을 이용하여 아래와 같은 위치기반서비스를 제공합니다.
                ① 유저의 위치정보에 기반하여 날씨에 맞는 음악 추천
                제5조 서비스 이용요금회사가 제공하는 위치기반서비스는 무료입니다.단, 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며, 이용자가 가입한 각 이동통신사의 정책에 따릅니다.
                제6조 서비스 이용의 제한·중지
                ① 회사는 위치기반서비스사업자의 정책변경 등과 같이 회사의 제반 사정 또는 법률상의 이유로 위치기반서비스를 유지할 수 없는 경우 위치기반서비스의 전부 또는 일부를 제한·변경·중지할 수 있습니다.
                ② 단, 위 항에 의한 위치기반서비스 중단의 경우 회사는 사전에 회사 홈페이지 등 기타 공지사항 페이지를 통해 공지하거나 이용자에게 통지합니다.
                제7조 개인위치정보의 이용 또는 제공
                ① 회사는 개인위치정보를 이용하여 위치기반서비스를 제공하는 경우 본 약관에 고지하고 동의를 받습니다.
                ② 회사는 이용자의 동의 없이 개인위치정보를 제3자에게 제공하지 않으며, 제3자에게 제공하는 경우에는 제공받는 자 및 제공 목적을 사전에 이용자에게 고지하고 동의를 받습니다.
                ③ 회사는 개인위치정보를 이용자가 지정하는 제3자에게 제공하는 경우 개인위치정보를 수집한 통신단말장치로 매회 이용자에게 제공받는 자, 제공 일시 및 제공 목적을 즉시 통지합니다.
                ④ 단, 아래의 경우 이용자가 미리 특정하여 지정한 통신단말장치 또는 전자우편주소, 온라인 게시 등으로 통지합니다.
                1.개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신 기능을 갖추지 아니한 경우
                2.이용자의 개인위치정보를 수집한 통신단말장치 외의 통신단말장치 또는 전자우편주소, 온라인 게시 등으로 통보할 것을 미리 요청한 경우
                ⑤ 회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 개인위치정보 이용·제공 사실 확인자료를 자동으로 기록·보존하며, 해당 자료는 6개월간 보관합니다.
                제8조 개인위치정보의 보유기간 및 이용기간
                ① 회사가 이용자 통신단말장치로부터 수집한 위치정보는 서비스 제공 후 별도 저장없이 즉시 파기합니다.
                제9조 개인위치정보주체의 권리
                ① 이용자는 언제든지 개인위치정보의 이용·제공에 대한 동의 전부 또는 일부를 유보할 수 있습니다.
                ② 이용자는 언제든지 개인위치정보의 이용·제공에 대한 동의 전부 또는 일부를 철회할 수 있습니다. 이 경우 회사는 지체 없이 철회된 범위의 개인위치정보 및 위치정보 이용·제공 사실 확인자료를 파기합니다.
                ③ 이용자는 개인위치정보의 이용·제공의 일시적인 중지를 요구할 수 있으며, 이 경우 회사는 이를 거절할 수 없고 이를 충족하는 기술적 수단을 마련합니다.
                ④ 이용자는 회사에 대하여 아래 자료에 대한 열람 또는 고지를 요구할 수 있으며, 해당 자료에 오류가 있는 경우에는 정정을 요구할 수 있습니다. 이 경우 정당한 사유 없이 요구를 거절하지 않습니다.
                1.이용자에 대한 위치정보 이용·제공 사실 확인자료
                2.이용자의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용
                ⑤ 이용자는 권리행사를 위해 본 약관 제15조의 연락처를 이용하여 회사에 요청할 수 있습니다
                제10조 법정대리인의 권리회사는 14세 미만의 이용자에 대해서는 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의를 이용자의 법정대리인으로부터 동의를 받아야 합니다. 이 경우 법정대리인은 본 약관 제9조에 의한 이용자의 권리를 모두 가집니다.
                제11조 8세 이하의 아동 동의 보호의무자의 권리
                ① 회사는 아래의 경우에 해당하는 자(이하 “8세 이하의 아동 등”)의 보호의무자(위치정보의 보호 및 이용 등에 관한 법률 제26조 제2항에 해당하는 자)가 8세 이하의 아동 등의 생명 또는 신체 보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.
                1.8세 이하의 아동
                2.피성년후견인
                3.장애인복지법 제2조 제2항 제2호에 따른 정신적 장애를 가진 사람으로서 장애인고용촉진 및 직업재활법 제2조 제2호에 따른 중증장애인에 해당하는 사람(장애인복지법 제32조에 따라 장애인 등록을 한 사람만 해당한다.)
                ② 8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다.
                ③ 보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 본 약관 제9조에 의한 이용자의 권리를 모두 가집니다.
                제12조 손해배상회사가 위치정보의 보호 및 이용 등에 관한 법률 제15조 및 26조의 규정을 위반한 행위로 인해 손해를 입은 경우 이용자는 회사에 손해배상을 청구할 수 있습니다. 회사는 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.
                제13조 면책
                ① 회사는 다음 각 호의 경우로 위치기반서비스를 제공할 수 없는 경우 이로 인하여 이용자에게 발생한 손해에 대해서는 책임을 부담하지 않습니다.
                1.천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우
                2.위치기반서비스 제공을 위하여 회사와 서비스 제휴계약을 체결한 제3자의 고의적인 서비스 방해가 있는 경우
                3.이용자의 귀책사유로 위치기반서비스 이용에 장애가 있는 경우
                4.제1호 내지 제3호를 제외한 기타 회사의 고의·과실이 없는 사유로 인한 경우
                ② 회사는 위치기반서비스 및 위치기반서비스에 게재된 정보, 자료, 사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 이용자의 손해에 대하여는 책임을 부담하지 아니합니다.
                제14조 분쟁의 조정 및 기타
                ① 회사는 위치정보와 관련된 분쟁의 해결을 위해 이용자와 성실히 협의합니다.
                ② 전항의 협의에서 분쟁이 해결되지 않은 경우, 회사와 이용자는 위치정보의 보호 및 이용 등에 관한 법률 제28조의 규정에 의해 방송통신위원회에 재정을 신청하거나, 개인정보보호법 제43조의 규정에 의해 개인정보 분쟁조정위원회에 조정을 신청할 수 있습니다.
                제15조 회사의 주소 및 연락처회사의 상호, 주소 및 연락처는 아래와 같습니다.
                • 상호 : 주식회사 카카오엔터테인먼트
                • 주소 : 경기도 성남시 분당구 판교역로 221
                • 대표전화 : 1566-7727
                부칙제1조 (시행일) 이 약관은 2023년 04월 17일부터 시행한다.제2조 위치정보관리책임자 정보회사는 개인위치정보를 적절히 관리·보호하고, 이용자의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를 위치정보관리책임자로 지정해 운영하고 있으며, 위치정보관리책임자는 개인정보 보호책임자가 겸직하며 성명과 연락처는 아래와 같습니다.
                • 성명 : 김현
                • 대표전화 : 1566-7727
                """
        
        
        self.view.addSubview(pinkView)
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // UIScrollView 생성 및 설정
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear // 배경을 투명하게 설정하여 pinkView의 색상이 보이도록 합니다.
        self.pinkView.addSubview(scrollView)
        
        // UIScrollView를 pinkView에 꽉 차게 설정합니다.
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        // UILabel 생성 및 설정
        let label = UILabel()
        label.numberOfLines = 0
        label.text = longText
        label.sizeToFit() // UILabel의 크기를 텍스트에 맞게 자동으로 조정합니다.
        
        // UILabel을 스크롤 가능한 scrollView의 서브뷰로 추가합니다.
        scrollView.addSubview(label)
        
        // UIScrollView의 컨텐츠 크기를 UILabel의 크기로 설정합니다.
        scrollView.contentSize = label.bounds.size
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}


