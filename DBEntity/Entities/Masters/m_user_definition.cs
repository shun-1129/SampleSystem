using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SampleSystem.DBEntity.Entities.Masters
{
    [Table ( "m_user_definition" )]
    public class m_user_definition : ColumnBase
    {
        /// <summary>
        /// ID
        /// </summary>
        [Key]
        [Required]
        public int id { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Required]
        public string name { get; set; } = string.Empty;

        /// <summary>
        /// 論理削除
        /// </summary>
        [Required]
        public bool is_deleted { get; set; }
    }
}
