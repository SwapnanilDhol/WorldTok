



import UIKit

class TimeTableViewCell : UITableViewCell
{
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var dayDifferenceLabel : UILabel!
    @IBOutlet weak var currentTimeLabel : UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    
    var timer = Timer()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()

        startTimer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @objc func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setTime), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: .common)
    }

    
    @objc func invalidateTimer()
    {timer.invalidate()
    }
    
    @objc func setTime()
    {
        currentTimeLabel.text = getTime()
        dayDifferenceLabel.text = getDayDifference()
        
    }
    
    func getTime() -> String
    {
        var timeString = ""
        
        if cityLabel.text != ""
        {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.timeZone = TimeZone(identifier: timeZoneLabel.text!)
            
            
            let timeNow = Date()
            timeString = formatter.string(from: timeNow)
              
        }
        return timeString
    }
    

    
    func getDayDifference() -> String
    {
        let timeNow = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneLabel.text!)
        dateFormatter.dateFormat = "dd-MM-yyyy" //give the formate according to your need

        
        return dateFormatter.string(from: timeNow)
        
     
    }

    
    
    func checkTimeStampz() -> String{
        
        
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        formatter.timeZone = TimeZone(identifier: cityLabel.text!)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let nowFormatter = DateFormatter()
        nowFormatter.timeStyle = .long
        nowFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let timeNow = Date()
        
        
        let foreignString = formatter.string(from: timeNow)
        return checkTimeStamp(date: foreignString)

    }
    
    
    func checkTimeStamp(date: String!) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let datecomponents = dateFormatter.date(from: date)

        let now = Date()

        if (datecomponents! > now) {
            return "Ahead of you. In time"
        } else if (datecomponents! < now){
            return "Same Date as you"
        }
        else
        {
            return "Test"
        }
    }

    
    
    
    
    
    
    
}
extension String {
    
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        
        return self.substring(from: range.upperBound)
    }
    
    
}
