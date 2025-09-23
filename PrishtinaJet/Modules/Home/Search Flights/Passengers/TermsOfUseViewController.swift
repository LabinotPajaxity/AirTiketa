//
//  TermsOfUseViewController.swift
//  AirTiketa
//
//  Created by Labi on 23. 9. 2025..
//

import Foundation
import UIKit

class TermsOfUseViewController: UIViewController {
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = true
        tv.font = .systemFont(ofSize: 14)
        tv.textColor = .darkGray
        return tv
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        view.addSubview(textView)
        view.addSubview(closeButton)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        textView.text = """
        Kushtet e Përdorimit – Kushtet e Përgjithshme të Biznesit
        ---------------------------------------------------------
        AirTiketa L.L.C  
        Sh. Rexhep Mala & Nuhi Berisha p.n, XK-60000 Gjilan / Kosovë  
        Pronar: Arbër Abdullahu | Nr. i firmës: 811425158  

        1. Juridiksioni i Kushteve të Përgjithshme  
        Të gjitha shërbimet e airtiketa.com (më tutje “AT”) ofrohen vetëm mbi bazën e këtyre Kushteve të Përgjithshme të Biznesit. Përjashtime vlejnë vetëm nëse janë bërë me marrëveshje të shkruar dhe janë konfirmuar nga AT me shkrim.  

        2. Oferta dhe Lidhja e Kontratës  
        Ofertat në sistemin online të rezervimit përbëjnë një kërkesë të detyrueshme për klientin. Me plotësimin e formularit të rezervimit, klienti lidhet detyrimisht për një kontratë transporti sipas kushteve të AT. Kontrata konsiderohet e lidhur kur AT e pranon rezervimin, qoftë përmes email-it të konfirmimit ose duke ngarkuar kartelën e kreditit.  

        3. Kushtet e Pagesës  
        Çmimet janë ato të konfirmuara gjatë rezervimit. Pagesa bëhet vetëm përmes kartelave të kreditit të pranuara nga AT. Nëse pagesa refuzohet nga banka ose institucioni i kartelave, AT ka të drejtë të ndërpresë kontratën dhe të anulojë rezervimin. Në këtë rast, për çdo pasagjer ngrihet një tarifë prej 30.00 €.  

        4. Premtimi për Konfidencialitet  
        AT garanton ruajtjen dhe konfidencialitetin e plotë të të gjitha të dhënave të klientëve.  

        5. Dokumentet e Udhëtimit  
        Pasagjeri merr konfirmimin e rezervimit përmes email-it, i cili shërben gjithashtu si biletë udhëtimi. Udhëtimi pa dokument të vlefshëm nuk pranohet. Biletat me të dhëna të pasakta në raport me pasagjerin janë të pavlefshme. Për rishfaqjen e biletave të humbura ose raste të tjera jashtë fajit të AT, ngrihet një tarifë përpunimi prej 30.00 € për biletë.  

        6. Ndryshimet e Rezervimeve dhe Anulimet  
        Ndryshimet dhe korrigjimet e emrave mund të bëhen kundrejt një tarife.  
        Anulimet pranohen vetëm me shkrim përmes email-it (info@airtiketa.com) deri në orën 18:00 të ditëve të punës. Anulimet e bëra në ditë festash ose të shtunave përpunohen në ditën e parë të punës.  

        Tarifat e anulimit janë si vijon:  
        - 10% për anulime deri në 30 ditë para nisjes  
        - 25% për anulime 29–21 ditë para nisjes  
        - 50% për anulime 21–14 ditë para nisjes  
        - 75% për anulime 14–7 ditë para nisjes  
        - 100% për anulime 7 ditë para nisjes ose pas fillimit të udhëtimit  

        Ndryshimet e emrave pas fillimit të udhëtimit nuk pranohen.  

        7. Koha e Check-in  
        Pasagjerët duhet të paraqiten në sportel të paktën 120 minuta para nisjes. Check-in mbyllet 40 minuta para nisjes. AT nuk mban përgjegjësi për vonesat e pasagjerëve.  

        8. Konfirmimi i Kthimit  
        Çdo klient duhet të konfirmojë fluturimin e kthimit brenda 24–48 orëve para nisjes, përmes telefonit në numrat e shënuar në biletë. Moskonfirmimi mund të rezultojë në humbjen e të drejtës për fluturim.  

        9. Bagazhi dhe Dokumentacioni  
        Lejohet deri në 20 kg bagazh për pasagjer. Bagazhi shtesë bartet kundrejt pagesës. Pasagjerët mbajnë përgjegjësinë për respektimin e rregullave të hyrjes në vendet e destinacionit. AT ka të drejtë të ngarkojë tarifat e shkeljeve.  

        10. Lehtësira për Fëmijë dhe Të Rinj  
        Fëmijët deri në 2 vjeç dhe të rinjtë deri në 11 vjeç përfitojnë tarifa të reduktuara. Vendimtare është mosha në ditën e nisjes.  

        11. Tjetërsimi i Kërkesave  
        Tjetërsimi i kërkesave kundër AT është i pavlefshëm.  

        12. Reklamimet  
        Reklamimet pranohen vetëm me shkrim menjëherë pas përfundimit të fluturimit, në adresën e caktuar nga AT.  

        13. Vendi i Arbitrazhit  
        Vendi i arbitrazhit është Gjykata Komerciale në Kosovë.  

        14. Klauzola e Shpëtimit  
        Nëse ndonjë dispozitë e këtyre kushteve është pjesërisht ose plotësisht e pavlefshme, vlefshmëria e kushteve të tjera mbetet e paprekur. Dispozitat e pavlefshme zëvendësohen me ato që janë më të përafërta me qëllimin fillestar.  

        15. Qëndrimi në Fuqi  
        Këto kushte vlejnë nga data 01.07.2020.  

        """
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
